import React from 'react';
import PropTypes from 'prop-types';

import HHLogo from 'components/HHLogo/HHLogo';
import Heading from 'components/Heading/Heading';
import ContentWrapper from 'components/ContentWrapper/ContentWrapper';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import SettingsIcon from 'components/Icons/SettingsIcon';

import './Header.css';

const Header = ({openSettings}) => (
    <header className="header">
        <ContentWrapper>
            <div className="header-content">
                <HHLogo size={50}/>
                <div className="header-content__title">
                    <Heading level={2}>CP-Helper</Heading>
                </div>
                <div className="header-content__btn">
                    <ButtonIcon onClick={openSettings}>
                        <SettingsIcon size={30}/>
                    </ButtonIcon>
                </div>
            </div>
        </ContentWrapper>
    </header>
);

Header.propTypes = {
    openSettings: PropTypes.func,
};

export default Header;
