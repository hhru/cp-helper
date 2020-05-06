import React, {useState} from 'react';
import PropTypes from 'prop-types';

import SelectWrapper from 'components/Select/SelectWrapper/SelectWrapper';
import SelectItem from 'components/Select/SelectItem/SelectItem';

import './Select.css';

const Select = ({items, choose}) => {

    const [selectOpen, setSelectOpen] = useState(false);
    const [inputValue, setInputValue] = useState('');

    const click = (id, string) => {
        setSelectOpen(false);
        setInputValue(string);
        choose(id);
    };

    const changeSelectState = () => {
        setSelectOpen(!selectOpen);
    };

    return (
        <div className="select">
            <input
                className={"select__input"}
                value={`${items ? (inputValue || items[0].string) : ''}`}
                onClick={changeSelectState}
                readOnly
            />
            <div className={`select__arrow ${selectOpen ? "select__arrow_open" : "select__arrow_close"}`}/>
            {
                selectOpen && items && <SelectWrapper lines={items.length}>
                    {
                        items.map((el) =>
                            <SelectItem
                                key={el.id}
                                name={el.string}
                                onClick={
                                    () => click(el.id, el.string)
                                }
                            />
                        )}
                </SelectWrapper>
            }
        </div>

    );
};

Select.propTypes = {
    items: PropTypes.array,
    choose: PropTypes.func,
};

export default Select;
