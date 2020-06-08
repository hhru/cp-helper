import React from 'react';
import PropTypes from "prop-types";

import Button from 'components/Button/Button';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import CloseIcon from 'components/Icons/CloseIcon';
import Search from 'components/Search/Search';

import './PopupSearch.css';

const PopupSearch = ({fetch, items, choose, payload, placeholderText, onClick, clickClose, buttonName}) => {
    return (
        <div className="popup-search">
            <div className="popup-search__field">
                <Search
                    fetch={fetch}
                    items={items}
                    choose={choose}
                    payload={payload}
                    placeholderText={placeholderText}
                >
                <div className="popup-search__btn">
                    <Button onClick={onClick} disabled={!payload}>{buttonName}</Button>
                </div>
                <div className="popup-search__close">
                    <ButtonIcon onClick={clickClose}>
                        <CloseIcon size={30}/>
                    </ButtonIcon>
                </div>
                </Search>
            </div>
        </div>
    );
};

PopupSearch.propTypes = {
    fetch: PropTypes.func,
    items: PropTypes.array,
    choose: PropTypes.func,
    payload: PropTypes.string,
    placeholderText: PropTypes.string,
    onClick: PropTypes.func,
    clickClose: PropTypes.func,
    buttonName: PropTypes.string,
};

export default PopupSearch;
