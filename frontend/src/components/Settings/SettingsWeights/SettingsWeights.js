import React, {useRef} from 'react';
import PropTypes from "prop-types";
import {connect} from 'react-redux';

import Heading from 'components/Heading/Heading';
import Weight from 'components/Settings/SettingsWeights/Weight/Weight';
import Button from 'components/Button/Button';

import createNotification from 'utils/notifications';

import {fetchWeights} from 'redux/competitors/competitorsActions';

import './SettingsWeights.css';

const SettingsWeights = ({fetchWeights}) => {

    const WEIGHTS = [
        { id: "spendingCountWeight", name: "Вес трат", ref: useRef()},
        { id: "vacancyAreaWeight", name: "Вес областей вакансий", ref: useRef()},
        { id: "vacansyMaskWeight", name: "Вес масок вакансий", ref: useRef()},
        { id: "staffNumberWeight", name: "Вес количества работников", ref: useRef()},
        { id: "profAreaWeights", name: "Вес профобластей вакансий", ref: useRef()},
    ];
    const MIN_WEIGHT = 0;
    const MAX_WEIGHT = 10;

    const saveWeights = () => {
        const weights = [];
        WEIGHTS.forEach((el) => {
            if (el.ref.current.value) {
                if (Number(el.ref.current.value) >= MIN_WEIGHT && Number(el.ref.current.value) <= MAX_WEIGHT) {
                    weights.push({id: el.id, value: el.ref.current.value});
                } else {
                    createNotification('error', 'Значения весов должны быть от 0 до 10', 'Ошибка');
                }
            }
        });
        fetchWeights(weights);
    };

    return (
        <div className="settings-weights">
            <div className="settings-weights__title">
                <Heading level={4}>Настройка весов критериев</Heading>
            </div>
            { WEIGHTS.map((weight) => (
                <Weight
                    key={weight.id}
                    refWeight={weight.ref}
                    name={weight.name}/>
            ))}
            {"* при необходимости введите вес от 0 до 10.0"}<br />{"(по умолчанию значение 1.0)"}
            <div className="settings-weights__btn">
                <Button onClick={saveWeights}>
                    Применить
                </Button>
            </div>
        </div>
    );
};

SettingsWeights.propTypes = {
    fetchWeights: PropTypes.func,
};

export default connect(
    null,
    {
        fetchWeights,
    }
)(SettingsWeights);
