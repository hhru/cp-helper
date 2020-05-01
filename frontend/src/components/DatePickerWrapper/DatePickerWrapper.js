import DatePicker from "react-datepicker";
import PropTypes from 'prop-types';
import "react-datepicker/dist/react-datepicker.css";
import React, { useState } from "react";
import "./DatePickerWrapper.css";

const DatePickerWrapper = ({ input, label, minDate, maxDate }) => {
    const [startDate, setStartDate] = useState(input.value);
    return (
        <div className="hh-datepicker-wrapper">
            <label className="hh-datepicker-wrapper__label">{label}</label>
            <DatePicker
                dateFormat="dd.MM.yyyy"
                showPopperArrow={false}
                showMonthDropdown
                dropdownMode="select"
                selected={startDate}
                minDate={minDate}
                maxDate={maxDate}
                onChange={(value) => {
                    setStartDate(value);
                    input.onChange(value);
                }}
                onBlur={input.onBlur}
                onFocus={input.onFocus}
                value={input.value}
                className="hh-input"
            />
        </div>
    );
};

DatePickerWrapper.propTypes = {
    input: PropTypes.object.isRequired,
    label: PropTypes.string,
    minDate: PropTypes.instanceOf(Date),
    maxDate: PropTypes.instanceOf(Date),
};

export default DatePickerWrapper;
