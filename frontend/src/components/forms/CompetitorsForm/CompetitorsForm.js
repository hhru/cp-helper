import React from "react";
import PropTypes from "prop-types";
import format from 'date-fns/format';
import { Form, Field } from "react-final-form";
import { addDays } from "date-fns";
import { connect } from 'react-redux';

import createNotification from 'utils/notifications';

import Button from "components/Button/Button";
import DatePickerWrapper from "components/DatePickerWrapper/DatePickerWrapper";

import { fetchServices } from 'redux/services/servicesActions';

import "./CompetitorsForm.css";

const CompetitorsForm = ({ competitors, openCommercialOffer, companyId, fetchServices }) => {

    const DEFAULT_DAYS_PERIOD = 7;

    const handleSubmit = async (values) => {
        const startDate = format(values.from, 'yyyy-MM-dd');
        const endDate = format(values.to, 'yyyy-MM-dd');
        fetchServices(companyId, competitors, startDate, endDate);
        openCommercialOffer();
    };

    const formValidate = (values) => {
        const errors = {};
        if (values.from > values.to) {
            createNotification('error', 'Значение "от" должно быть меньше значения "до"', 'Ошибка');
            errors.from = true;
        }
        return errors;
    };

    return (
        <Form
            onSubmit={handleSubmit}
            initialValues={{
                from: addDays(new Date(), -DEFAULT_DAYS_PERIOD),
                to: new Date(),
            }}
            validate={formValidate}
            render={({ handleSubmit }) => (
                <form onSubmit={handleSubmit}>
                    <div className="hh-competitors-form__period">
                        <Field name="from">
                            {({ input }) => (
                                <DatePickerWrapper
                                    input={input}
                                    label="От"
                                    maxDate={new Date()}
                                />
                            )}
                        </Field>
                        <Field
                            name="to"
                            component={DatePickerWrapper}
                            label="До"
                            maxDate={new Date()}
                        />
                        <Button type="submit">
                            Получить услуги
                        </Button>
                    </div>
                </form>
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
    () => {},
    {
        fetchServices,
    }
)(CompetitorsForm);
