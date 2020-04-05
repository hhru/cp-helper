import React, {useState, Fragment} from 'react';
import {connect} from 'react-redux';

import Input from 'components/Input/Input';
import SelectWrapper from 'components/Select/SelectWrapper/SelectWrapper';
import SelectItem from 'components/Select/SelectItem/SelectItem';

import {fetchArea, chooseArea} from 'redux/AreaSearch/areaSearchAction';
import {initArea} from 'redux/AreaInit/areaInitAction';

const AreasSearch = ({ initArea, plainAreas, fetchArea, areas, chooseArea, areaId }) => {

    const [selectOpen, setSelectOpen] = useState(false);
    const [inputAreaValue, setInputAreaValue] = useState('');

    const SELECT_ITEMS_LENGTH = 7;

    const inputArea = React.useRef(null);

    const handleInputChange = () => {
        setInputAreaValue(inputArea.current.value);
        if ((Array.isArray(plainAreas)) && (plainAreas.length == 0)) {
            initArea();
        }
        console.log('in change input', plainAreas);
        fetchArea(inputArea.current.value);
        setSelectOpen(true);
        if (areaId) {
            chooseArea(null);
        }
    };

    const clickArea = (id, name) => {
        setSelectOpen(false);
        setInputAreaValue(name);
        chooseArea(id);
    };

    return (
        <Fragment>
            <Input
                ref={inputArea}
                placeholderText={'Введите название региона'}
                onChange={handleInputChange}
                value={inputAreaValue}
            />
            {
                selectOpen && areas && <SelectWrapper lines=
                    {
                        areas.length > SELECT_ITEMS_LENGTH - 1 ? SELECT_ITEMS_LENGTH : areas.length
                    }>
                    {
                        areas.map(el =>
                            <SelectItem
                                key={el.id}
                                id={el.id}
                                name={el.name}
                                onClick={() => clickArea(el.id, el.name)}
                            />,
                        )}
                </SelectWrapper>
            }
        </Fragment>
    );
};

export default connect(
    state => ({
        areaId: state.areaSearch.areaId,
        areas: state.areaSearch.areas,
        plainAreas: state.areaInit.plainAreas
    }),
    {
        fetchArea,
        chooseArea,
        initArea
    },
)(AreasSearch);