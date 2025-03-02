import React from 'react';

import { {{name}}Props } from './{{name}}.model.ts'
import './{{name}}.styles.css';

const {{name}}: React.FC<{{name}}Props> = ({}) => {
  return (
    <div className="container">
      <h1>{{name}}</h1>
    </div>
  );
};

export default {{name}};
