import React from 'react';

import HHLogo from 'components/HHLogo/HHLogo';
import Heading from 'components/Heading/Heading';
import ContentWrapper from 'components/ContentWrapper/ContentWrapper';

import './Header.css';

const Header = () => (
    <header className="header">
        <ContentWrapper>
            <div className="header-content">
                <HHLogo size={50}/>
                <div className="header-content__title">
                    <Heading level={2}>CP-Helper</Heading>
                </div>
            </div>
        </ContentWrapper>
    </header>
);

export default Header;
