import React from "react";
import PropTypes from "prop-types";
import Button from "components/Button/Button";
import format from 'date-fns/format';
import { Form, Field } from "react-final-form";
import { addDays } from "date-fns";
import DatePickerWrapper from "components/DatePickerWrapper/DatePickerWrapper";
import "./CompetitorsForm.css";

const CompetitorsForm = ({ competitors }) => {
    const DEFAULT_DAYS_PERIOD = 7;

    const handleSubmit = async (values) => {
        const startDate = format(values.from, 'yyyy-MM-dd');
        const endDate = format(values.to, 'yyyy-MM-dd');
        // TODO: добавить запрос на получение услуг
        const requestData = { startDate, endDate, competitors };
        // eslint-disable-next-line no-console
        console.log(requestData);
    };

    const formValidate = (values) => {
        const errors = {};
        if (values.from > values.to) {
            errors.from = 'Значение "от" должно быть меньше значения "до"';
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
            render={({ handleSubmit, submitting }) => (
                <form onSubmit={handleSubmit}>
                    <div className="hh-competitors-form__period">
                        <Field name="from">
                            {({ input, meta }) => (
                                <>
                                    <DatePickerWrapper
                                        input={input}
                                        label="От"
                                        maxDate={new Date()}
                                    />
                                    {meta.error && meta.touched && (
                                        <div className="hh-form-error">{meta.error}</div>
                                    )}
                                </>
                            )}
                        </Field>
                        <Field
                            name="to"
                            component={DatePickerWrapper}
                            label="До"
                            maxDate={new Date()}
                        />
                        <Button type="submit" disabled={submitting}>
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
};

export default CompetitorsForm;
