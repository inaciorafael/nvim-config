import { inferType } from "./infer";

export function capitalize(value: string): string {
  if (!value) return value;
  return value.charAt(0).toUpperCase() + value.slice(1);
}

export function generateInterfaces(
  name: string,
  obj: Record<string, any>,
  acc: string[] = []
): string[] {
  const fields = Object.entries(obj).map(([key, value]) => {
    if (typeof value === 'object' && value !== null && !Array.isArray(value)) {
      const childName = capitalize(key);
      generateInterfaces(childName, value, acc)
      return `  ${key}: ${childName}`;
    }

    return `  ${key}: ${inferType(value)}`;
  })

  acc.push(`export interface ${name} {\n${fields.join('\n')}\n}`);
  return acc;
}
