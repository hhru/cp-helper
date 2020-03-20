import React from 'react';

import Copyright from 'components/Copyright/Copyright';
import ContentWrapper from 'components/ContentWrapper/ContentWrapper';

import './Footer.css';


const Footer = () => {

    const now = new Date();

    return (
        <footer className="footer">
            <ContentWrapper>
                <div className="footer-content">
                    <Copyright year={now.getFullYear()}/>
                </div>
            </ContentWrapper>
        </footer>
    );
};

export default Footer;
