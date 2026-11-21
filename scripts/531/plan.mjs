#!/usr/bin/env node
import { readFileSync } from 'node:fs';

const config = JSON.parse(readFileSync(new URL('config.json', import.meta.url), 'utf8'));

const weeks = [
  { sets: [[65, '5'], [75, '5'], [85, '5+']] },
  { sets: [[70, '3'], [80, '3'], [90, '3+']] },
  { sets: [[75, '5'], [85, '3'], [95, '1+']] },
];

const assistanceLabels = { singleLeg: 'Single Leg', pull: 'Pull', push: 'Push', core: 'Core' };

const weight = (lift, percent) => {
  const rounding = lift.rounding ?? 2.5;
  return `${Math.round((lift.tm * percent) / 100 / rounding) * rounding}kg`;
};

const mainSets = (lift, sets) =>
  `${lift.short} ${sets.map(([percent, reps]) => `${weight(lift, percent)} ×${reps}`).join(', ')}:`;

const supplemental = (lift, sets) => {
  switch (lift.supplemental) {
    case 'fsl':
      return [`${lift.short} FSL ${weight(lift, sets[0][0])} ${config.fsl.sets}:`];
    case 'bbb':
      return [`${lift.short} BBB ${weight(lift, config.bbb.percent)} ${config.bbb.sets}:`];
    default:
      return [];
  }
};

const assistance = (lift) =>
  Object.entries(assistanceLabels).flatMap(([key, label]) => {
    const group = lift.assistance?.[key];
    if (!group) return [];
    return [`${label} ${group.reps}:`, ...group.exercises.map((exercise) => ` - ${exercise}:`)];
  });

const conditioning = (lift) =>
  lift.conditioning ? `Conditioning: ${lift.conditioning}` : 'Conditioning:';

const session = (lift, sets) => [
  lift.name.toUpperCase(),
  'DATE:',
  'Jumps:',
  mainSets(lift, sets),
  ...supplemental(lift, sets),
  ...assistance(lift),
  conditioning(lift),
];

const deloadSession = (lifts) => [
  `${lifts.map((lift) => lift.name.toUpperCase()).join(' / ')} (DELOAD)`,
  'DATE:',
  ...lifts.map((lift) => `${lift.short} work up to ${lift.tm}kg ×1:`),
];

// Deload: the first two lifts get their own session, the rest share one.
const [firstLift, secondLift, ...otherLifts] = config.lifts;

const sessions = [
  ...weeks.flatMap(({ sets }) => config.lifts.map((lift) => session(lift, sets))),
  ...[[firstLift], [secondLift], otherLifts].map(deloadSession),
];

const trainingMaxes = [
  'TRAINING MAXES',
  ...config.lifts.map((lift) => `${lift.name}: ${lift.tm}kg`),
].join('\n');

console.log(
  [
    trainingMaxes,
    ...sessions.map(([title, ...lines], i) => [`SESSION ${i + 1}: ${title}`, ...lines].join('\n')),
  ].join('\n\n'),
);
