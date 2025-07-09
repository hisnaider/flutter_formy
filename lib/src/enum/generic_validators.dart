enum GenericValidators {
  isRequired,
  invalidEmail,
  minLength,
  maxLength,
  betweenLength,
  invalidNumber,
  mustBeNumeric,
  invalidCPF,
  invalidCNPJ,
  invalidPhone,
  onlyLetters,
  onlyAlphanumeric,

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
