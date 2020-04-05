/* eslint-disable quote-props */
import React from 'react';
import classNames from 'classnames';

import ContentWrapper from 'components/ContentWrapper/ContentWrapper';
import ColumnsWrapper from 'components/ColumnsWrapper/ColumnsWrapper';
import Columns from 'components/Columns/Columns';

import {COMPANY_SEARCH, COMPETITORS_LIST, CORPORATE_OFFER} from '../MainComponent';

import './Tab.css';


const Tab = ({children, currentTab}) => {
    return (
        <ContentWrapper>
            <div className="tab">
                <ColumnsWrapper>
                    <Columns s={1} m={2} l={4}>
                        <div className={classNames(
                            'tab__element',
                            {'tab__element_active': currentTab === COMPANY_SEARCH},
                        )}>
                            1. Поиск по компаниям
                        </div>
                    </Columns>
                    <Columns s={1} m={2} l={4}>
                        <div className={classNames(
                            'tab__element',
                            {'tab__element_active': currentTab === COMPETITORS_LIST},
                        )}>
                            2. Просмотр конкурентов
                        </div>
                    </Columns>
                    <Columns s={1} m={2} l={4}>
                        <div className={classNames(
                            'tab__element',
                            {'tab__element_active': currentTab === CORPORATE_OFFER},
                        )}>
                            3. Корпоративное предложение
                        </div>
                    </Columns>
                </ColumnsWrapper>
            </div>
            <div className="tab-content">
                {children}
            </div>
        </ContentWrapper>
    );
};

export default Tab;
