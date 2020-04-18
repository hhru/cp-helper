import React from "react";
import Button from "components/Button/Button";
import { Form, Field } from "react-final-form";
import { addDays } from "date-fns";
import DatePickerWrapper from "components/DatePickerWrapper/DatePickerWrapper";
import "./CompetitorsForm.css";

const CompetitorsForm = ({ competitors }) => {
  const handleSubmit = async (values) => {
    // TODO: добавить запрос на получение услуг
    const requestData = { ...values, competitors };
    console.log(requestData);
  };

  return (
    <Form
      onSubmit={handleSubmit}
      initialValues={{
        from: addDays(new Date(), -7),
        to: new Date(),
      }}
      validate={(values) => {
        const errors = {};
        if (values.from > values.to) {
          errors.from = 'Значение "от" должно быть меньше значения "до"';
        }
        return errors;
      }}
      render={({ handleSubmit, submitting }) => (
        <form onSubmit={handleSubmit}>
          <div className="hh-competitors-form__period">
            <Field name="from">
              {({ input, meta }) => (
                <div>
                  <DatePickerWrapper
                    input={input}
                    label="От"
                    maxDate={new Date()}
                  />
                  {meta.error && meta.touched && (
                    <div className="hh-form-error">{meta.error}</div>
                  )}
                </div>
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

export default CompetitorsForm;
