import React from 'react';
import './Competitor.css';

const Competitor = ({logo, name}) => {

    return (
        <div className="competitor">
            <div className="competitor__logo">
                <img src={logo} alt={name} height="20px"></img>
            </div>
            <div className="competitor__name">
                {name}
            </div>
        </div>
    );
};

export default Competitor;
