import React from 'react';

import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import DeleteIcon from 'components/Icons/DeleteIcon';

import './Competitor.css';


const Competitor = ({logo, name, deleteCompetitor}) => {

    return (
        <div className="competitor">
            <div className="competitor__logo">
                <img src={logo} alt={name} height="20px"></img>
            </div>
            <div className="competitor__name">
                {name}
            </div>
            <div className="competitor__delete">
                <ButtonIcon onClick={deleteCompetitor}> 
                    <DeleteIcon size={20}/>
                </ButtonIcon>
            </div>
        </div>
    );
};

export default Competitor;
