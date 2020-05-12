import React, {useState} from "react";
import PropTypes from "prop-types";
import format from 'date-fns/format';
import { Form, Field } from "react-final-form";
import { addDays } from "date-fns";
import { connect } from 'react-redux';

import createNotification from 'utils/notifications';

import Button from "components/Button/Button";
import DatePickerWrapper from "components/DatePickerWrapper/DatePickerWrapper";
import Select from "components/Select/Select/Select";
import Checkbox from "components/Checkbox/Checkbox";

import { fetchServices } from 'redux/services/servicesActions';

import "./CompetitorsForm.css";

const CompetitorsForm = ({ competitors, openCommercialOffer, companyId, fetchServices }) => {

    const DEFAULT_DAYS_PERIOD = 7;
    const DEFAULT_PERIODS = [3, 7, 14, 30];

    const [period, setPeriod] = useState(DEFAULT_PERIODS[0]);
    const [isSearchByDate, setIsSearchByDate] = useState(false);

    const getStringDay = (periods) => {
        return periods.map((el) => {
            if (el % 10 === 1 && el % 100 !== 11) {
                return {id: el, string: `${el} день`};
            } else if ([2, 3, 4].includes(el % 10) && ![12, 13, 14].includes(el % 100)) {
                return {id: el, string: `${el} дня`};
            }
            return {id: el, string: `${el} дней`};
        });
    };

    const getFormattedDate = (dateFrom, dateTo) => {
        const startDate = format(dateFrom, 'yyyy-MM-dd');
        const endDate = format(dateTo, 'yyyy-MM-dd');
        return {startDate, endDate};
    };

    const handleSubmit = async (values) => {
        let date = {};
        if (isSearchByDate) {
            if (values.from > values.to) {
                createNotification('error', 'Значение "от" должно быть меньше значения "до"', 'Ошибка');
            } else {
                date = getFormattedDate(values.from, values.to);
            }
        } else {
            date = getFormattedDate(addDays(new Date(), -period), new Date());
        }
        if (date.startDate && date.endDate) {
            fetchServices(companyId, competitors, date.startDate, date.endDate);
            openCommercialOffer();
        }
    };

    const toggleTypeSearch = () => {
        setIsSearchByDate(!isSearchByDate);
    };

    return (
        <Form
            onSubmit={handleSubmit}
            initialValues={{
                from: addDays(new Date(), -DEFAULT_DAYS_PERIOD),
                to: new Date(),
            }}
            render={({ handleSubmit }) => (
                <div className="hh-competitors-form">
                    <form onSubmit={handleSubmit}>
                        <div className="hh-competitors-form__period">
                            <div className="hh-competitors-form__label">
                                Проанализировать услуги за последние
                            </div>
                            <Select
                                items={getStringDay(DEFAULT_PERIODS)}
                                choose={setPeriod}
                            />
                            <div className="hh-competitors-form__btn">
                                <Button type="submit">
                                    Получить услуги
                                </Button>
                            </div>
                        </div>
                        <div className="hh-competitors-form__checkbox">
                            <Checkbox
                                labelText="Выбрать определенные даты"
                                id="date"
                                onChange={toggleTypeSearch}
                            />
                        </div>
                        {isSearchByDate &&
                            <div className="hh-competitors-form__date">
                                <Field
                                    name="from"
                                    component={DatePickerWrapper}
                                    label="От"
                                    maxDate={new Date()}
                                />
                                <Field
                                    name="to"
                                    component={DatePickerWrapper}
                                    label="До"
                                    maxDate={new Date()}
                                />
                            </div>}
                    </form>
                </div>
            )}
        />
    );
};

CompetitorsForm.propTypes = {
    competitors: PropTypes.object,
    openCommercialOffer: PropTypes.func,
    fetchServices: PropTypes.func,
    companyId: PropTypes.string,
};

export default connect(
    null,
    {
        fetchServices,
    }
)(CompetitorsForm);
