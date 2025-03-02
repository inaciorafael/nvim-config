import React from 'react';
import { use{{Name}}Model } from './{{name}}.model'

import { Page{{Name}}Props } from './{{name}}.types.ts'
import './{{name}}.styles.css';

const {{Name}}: React.FC<Page{{Name}}Props> = ({}) => {
  const { pageName } = use{{Name}}Model()

  return (
    <div className="container">
      <h1>{pageName} works!</h1>
    </div>
  );
};

export default {{Name}};
