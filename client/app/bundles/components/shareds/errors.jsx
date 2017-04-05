import React from 'react';

export default class Errors extends React.Component {
  render() {
    if(this.props.errors) {
      let errors = Object.keys(this.props.errors).map(attribute => {
        return this.props.errors[attribute].map((error, index) => {
          return <li key={`${attribute}_${index}`}>{attribute} {error}</li>
        });
      });
      return (
        <div className='error-explanation'>
          <ul>
            {errors}
          </ul>
        </div>
      );
    }

    return null;
  }
}
