enum GenericValidators {
  isRequired,
  invalidEmail,
  minLength,
  maxLength,
  exactLength,
  betweenLength,
  or,

  //numeric:
  minValue,
  maxValue,
  betweenValues,
  positiveNum,
  negativeNum,
  nonZeroNum,
  evenNum,
  oddNum,
  divisibleBy,

  //string:
  pattern,
  startWith,
  endWith,
  contains,
  notContains,
  noSpaces,
  noSpecialChars,
  noNumbers,
  ip,
  url,

  //Datetime:
  beforeDate,
  afterDate,
  betweenDates,
  minAge,
  maxAge,

  //crossed:
  mustMatch,
  mustNotMatch,
  biggerThan,
  lessThan,
}
