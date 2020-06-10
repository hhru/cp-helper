import React from 'react';
import PropTypes from 'prop-types';

import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import DeleteIcon from 'components/Icons/DeleteIcon';

import './Competitor.css';

const Competitor = ({logo, name, deleteCompetitor}) => {

    return (
        <div className="competitor">
            <div className="competitor__logo">
                {logo && <img src={logo} alt={name} height="20px"></img>}
            </div>
            <div className="competitor__name">
                {name.length < 15 ?
                    name
                    :
                    <>
                        {name.slice(0, 15)}...
                        <div className="competitor__name_full">
                            {name}
                        </div>
                    </>
                }
            </div>
            <div className="competitor__delete">
                <ButtonIcon onClick={deleteCompetitor}>
                    <DeleteIcon size={20}/>
                </ButtonIcon>
            </div>
        </div>
    );
};

Competitor.propTypes = {
    logo: PropTypes.string,
    name: PropTypes.string.isRequired,
    deleteCompetitor: PropTypes.func.isRequired,
};

export default Competitor;
