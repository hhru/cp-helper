import React from 'react';
import PropTypes from 'prop-types';

import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import DeleteIcon from 'components/Icons/DeleteIcon';
import Columns from 'components/Columns/Columns';

import './Company.css';

const Company = ({name, deleteCompany}) => {

    return (
        <Columns s={2} m={2} l={4}>
            <div className="company">
                <div className="company__name">
                    {name.length < 20 ?
                        name
                        :
                        <>
                            {name.slice(0, 20)}...
                            <div className="company__name_full">
                                {name}
                            </div>
                        </>
                    }
                </div>
                <div className="company__delete">
                    <ButtonIcon onClick={deleteCompany}>
                        <DeleteIcon size={15}/>
                    </ButtonIcon>
                </div>
            </div>
        </Columns>
    );
};

Company.propTypes = {
    name: PropTypes.string.isRequired,
    deleteCompany: PropTypes.func,
};

export default Company;
