import React, {useState, Fragment, useEffect} from 'react';
import {connect} from 'react-redux';

import Input from 'components/Input/Input';
import SelectWrapper from 'components/Select/SelectWrapper/SelectWrapper';
import SelectItem from 'components/Select/SelectItem/SelectItem';

import {fetchArea, chooseArea} from 'redux/AreaSearch/areaSearchAction';
import axios from 'axios';

async function initAreas() {
    const url = `https://api.hh.ru/areas`;
    const areas = await axios.get(url);
    const result = getPlainAreas(areas.data);
    return result;
}

function getPlainAreas(hierachyAreas) {
    let plainAreas = [];
    hierachyAreas.forEach(
        function(area) {
            Array.prototype.push.apply(plainAreas, recurseAreaProcessing(area));
        }
    );
    return plainAreas;
}

function recurseAreaProcessing(area) {
    if (area.areas.length == 0) {;
        return [{"id" : area.id, "name" : area.name}];
    } else {
        let result = [{"id" : area.id, "name" : area.name}];
        area.areas.forEach(
            function(ar) {
                Array.prototype.push.apply(result, recurseAreaProcessing(ar));
            }
        );
        return result;
    }
}

const AreasSearch = ({ fetchArea, areas, chooseArea, areaId }) => {

    const [selectOpen, setSelectOpen] = useState(false);
    const [inputAreaValue, setInputAreaValue] = useState('');
    const [plainAreas, setPlainAreas] = useState([]);

    const SELECT_ITEMS_LENGTH = 7;

    const inputArea = React.useRef(null);

    
    
    useEffect(() => {
        if (plainAreas.length == 0) {
            initAreas().then(result => setPlainAreas(result));
        }
    }, []);
    
    const handleInputChange = () => {
        setInputAreaValue(inputArea.current.value);
        fetchArea(inputArea.current.value, plainAreas);
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
    }),
    {
        fetchArea,
        chooseArea,
    },
)(AreasSearch);