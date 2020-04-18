import React, { useState } from "react";
import "./DatePickerWrapper.css";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

const DatePickerWrapper = (props) => {
  const { input, label, minDate, maxDate } = props;
  const [startDate, setStartDate] = useState(input.value);
  return (
    <div className="hh-datepicker-wrapper">
      <label>{label}</label>
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
          props.input.onChange(value);
        }}
        onBlur={props.input.onBlur}
        onFocus={props.input.onFocus}
        value={props.input.value}
        className="hh-input"
      />
    </div>
  );
};

export default DatePickerWrapper;
