export function inferType(value: any): string {
  if (value === null) return 'null';

  if (Array.isArray(value)) {
    if (value.length === 0) return 'any[]';

    const types = [...new Set(value.map(inferType))];
    return types.length === 1 ? `${types[0]}[]` : `(${types.join(' | ')})[]`;
  }

  switch (typeof value) {
    case 'string':
      return 'string';
    case 'number':
      return 'number';
    case 'boolean':
      return 'boolean';
    case 'object':
      return 'object';
    default:
      return 'any';
  }
}
