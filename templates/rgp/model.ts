import { useState } from 'react'
import { Use{{Name}}Return } from './{{name}}.types'

export const use{{Name}}Model = (): Use{{Name}}Return => {
  const [pageName, setPageName] = useState<string>('{{name}}')

  const handleChangePageName = (name: string): void => setPageName(name)

  return {
    pageName,
    handleChangePageName,
  };
}
