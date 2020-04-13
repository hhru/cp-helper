import React, {useState, Fragment} from 'react';
import {connect} from 'react-redux';

import Input from 'components/Input/Input';
import SelectWrapper from 'components/Select/SelectWrapper/SelectWrapper';
import SelectItem from 'components/Select/SelectItem/SelectItem';

import {fetchCompany} from 'redux/search/searchActions';

import './Search.css';


const Search = ({ children, fetchCompany, companies, choose, onClick, payload }) => {

    const [selectOpen, setSelectOpen] = useState(false);
    const [inputCompanyValue, setInputCompanyValue] = useState('');

    const SELECT_ITEMS_LENGTH = 7;

    const inputCompany = React.useRef(null);

    const handleInputChange = () => {
        setInputCompanyValue(inputCompany.current.value);
        fetchCompany(inputCompany.current.value);
        setSelectOpen(true);
        if (payload) {
            choose(undefined);
        }
    };

    const clickCompany = (id, name) => {
        setSelectOpen(false);
        setInputCompanyValue(name);
        choose(id);
    };

    return (
        <div className="search">
            <div className="search__select">
                <Input
                    ref={inputCompany}
                    placeholderText={'Введите название компании'}
                    onChange={handleInputChange}
                    value={inputCompanyValue}
                />
                {
                    selectOpen && companies && <SelectWrapper lines=
                        {
                            companies.length > SELECT_ITEMS_LENGTH - 1 ? SELECT_ITEMS_LENGTH : companies.length
                        }>
                        {
                            companies.map(el =>
                                <SelectItem
                                    key={el.id}
                                    id={el.id}
                                    name={el.name}
                                    onClick={() => clickCompany(el.id, el.name)}
                                />,
                            )}
                    </SelectWrapper>
                }
            </div>
            {children}
        </div>
            
    );
};

export default connect(
    state => ({
        companies: state.search.companies,
    }),
    {
        fetchCompany,
    },
)(Search);
