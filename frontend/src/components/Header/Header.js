import React from 'react';

import HHLogo from 'components/HHLogo/HHLogo';
import ContentWrapper from 'components/ContentWrapper/ContentWrapper';

import './Header.css';


const Header = () => (
    <header className="header">
        <ContentWrapper>
            <HHLogo size={50}/>
        </ContentWrapper>
    </header>
);

export default Header;
