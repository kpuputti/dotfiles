#!/usr/bin/env node
import { readFileSync } from 'node:fs';

const config = JSON.parse(readFileSync(new URL('config.json', import.meta.url), 'utf8'));

const weeks = [
  { sets: [[65, '5'], [75, '5'], [85, '5+']] },
  { sets: [[70, '3'], [80, '3'], [90, '3+']] },
  { sets: [[75, '5'], [85, '3'], [95, '1+']] },
  { sets: [[40, '5'], [50, '5'], [60, '5']], deload: true },
];

const weight = (tm, percent) =>
  `${Math.round((tm * percent) / 100 / config.rounding) * config.rounding}${config.unit}`;

const mainSets = (lift, sets) =>
  `${lift.short} ${sets.map(([percent, reps]) => `${weight(lift.tm, percent)} ×${reps}`).join(', ')}:`;

const supplemental = (lift, sets) => {
  switch (lift.supplemental) {
    case 'fsl':
      return [`${lift.short} FSL ${weight(lift.tm, sets[0][0])} ${config.fsl.sets}:`];
    case 'bbb':
      return [`${lift.short} BBB ${weight(lift.tm, config.bbb.percent)} ${config.bbb.sets}:`];
    default:
      return [];
  }
};

// Array entries alternate by session; options rotate each time their entry is used.
const assistance = (index) =>
  config.assistance.map((entry) => {
    const entries = Array.isArray(entry) ? entry : [entry];
    const { label, reps, options } = entries[index % entries.length];
    const turn = Math.floor(index / entries.length);
    return `${label} [${options[turn % options.length]}] ${reps}:`;
  });

const session = (index, lift, { sets, deload }) => {
  const title = `SESSION ${config.firstSession + index}: ${lift.name.toUpperCase()}`;
  if (deload) {
    return [`${title} (DELOAD)`, 'DATE:', mainSets(lift, sets)].join('\n');
  }
  const lines = [
    title,
    'DATE:',
    ...lift.before.map((line) => `${line}:`),
    mainSets(lift, sets),
    ...supplemental(lift, sets),
    ...assistance(index),
    ...lift.after.map((line) => `${line}:`),
  ];
  return lines.join('\n');
};

const plan = weeks.flatMap((week) => config.lifts.map((lift) => ({ lift, week })));

const trainingMaxes = [
  'TRAINING MAXES',
  ...config.lifts.map((lift) => `${lift.name}: ${lift.tm}${config.unit}`),
].join('\n');

console.log(
  [
    JSON.stringify(config),
    trainingMaxes,
    ...plan.map(({ lift, week }, i) => session(i, lift, week)),
  ].join('\n\n'),
);
