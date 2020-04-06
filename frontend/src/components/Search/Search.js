import React, {useState, Fragment} from 'react';
import {connect} from 'react-redux';

import Input from 'components/Input/Input';
import SelectWrapper from 'components/Select/SelectWrapper/SelectWrapper';
import SelectItem from 'components/Select/SelectItem/SelectItem';

import {fetchCompany, chooseCompany} from 'redux/search/searchActions';


const Search = ({ fetchCompany, companies, chooseCompany, companyId }) => {

    const [selectOpen, setSelectOpen] = useState(false);
    const [inputCompanyValue, setInputCompanyValue] = useState('');

    const SELECT_ITEMS_LENGTH = 7;

    const inputCompany = React.useRef(null);

    const handleInputChange = () => {
        setInputCompanyValue(inputCompany.current.value);
        fetchCompany(inputCompany.current.value);
        setSelectOpen(true);
        if (companyId) {
            chooseCompany(null);
        }
    };

    const clickCompany = (id, name) => {
        setSelectOpen(false);
        setInputCompanyValue(name);
        chooseCompany(id);
    };

    return (
        <Fragment>
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
        </Fragment>
    );
};

export default connect(
    state => ({
        companyId: state.search.companyId,
        companies: state.search.companies,
    }),
    {
        fetchCompany,
        chooseCompany,
    },
)(Search);
