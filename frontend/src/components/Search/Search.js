import React, {useState, useRef, useEffect} from 'react';
import PropTypes from 'prop-types';

import Input from 'components/Input/Input';
import SelectWrapper from 'components/Select/SelectWrapper/SelectWrapper';
import SelectItem from 'components/Select/SelectItem/SelectItem';

import './Search.css';

const Search = ({
    fetch,
    items,
    choose,
    payload,
    placeholderText,
    children,
    initialValue,
}) => {

    const [selectOpen, setSelectOpen] = useState(false);
    const [inputValue, setInputValue] = useState('');

    const SELECT_ITEMS_LENGTH = 7;

    const input = useRef(null);
    useEffect(() => {
        setInputValue(initialValue);
    }, [initialValue]);

    const handleInputChange = () => {
        setInputValue(input.current.value);
        fetch(input.current.value);
        setSelectOpen(true);
        if (payload) {
            choose(undefined, undefined);
        }
    };

    const click = (id, name) => {
        setSelectOpen(false);
        setInputValue(name);
        choose(id, name);
    };

    return (
        <div className="search">
            <div className="search__select">
                <Input
                    ref={input}
                    placeholderText={placeholderText}
                    onChange={handleInputChange}
                    value={inputValue}
                />
                {
                    selectOpen && items && <SelectWrapper lines=
                        {
                            items.length > SELECT_ITEMS_LENGTH - 1 ? SELECT_ITEMS_LENGTH : items.length
                        }>
                        {
                            items.map((el) =>
                                <SelectItem
                                    key={el.id}
                                    id={el.id}
                                    name={el.name}
                                    onClick={() => click(el.id, el.name)}
                                />
                            )}
                    </SelectWrapper>
                }
            </div>
            {children}
        </div>

    );
};

Search.defaultProps = {
    placeholderText: 'Введите текст',
};

Search.propTypes = {
    fetch: PropTypes.func.isRequired,
    items: PropTypes.array,
    choose: PropTypes.func.isRequired,
    payload: PropTypes.string,
    placeholderText: PropTypes.string,
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]),
    initialValue: PropTypes.string,
};

export default Search;
