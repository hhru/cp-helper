/* eslint-disable quote-props */
import React from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';

import ContentWrapper from 'components/ContentWrapper/ContentWrapper';
import ColumnsWrapper from 'components/ColumnsWrapper/ColumnsWrapper';
import Columns from 'components/Columns/Columns';

import {COMPANY_SEARCH, COMPETITORS_LIST, COMMERCIAL_OFFER} from '../MainComponent';

import './Tab.css';

const Tab = ({children, currentTab}) => {
    return (
        <div className="content">
            <ContentWrapper>
                <div className="tab">
                    <ColumnsWrapper>
                        <Columns s={2} m={2} l={4}>
                            <div className={classNames(
                                'tab__element',
                                {'tab__element_active': currentTab === COMPANY_SEARCH}
                            )}>
                                1. Поиск по компаниям
                            </div>
                        </Columns>
                        <Columns s={2} m={2} l={4}>
                            <div className={classNames(
                                'tab__element',
                                {'tab__element_active': currentTab === COMPETITORS_LIST}
                            )}>
                                2. Просмотр конкурентов
                            </div>
                        </Columns>
                        <Columns s={2} m={2} l={4}>
                            <div className={classNames(
                                'tab__element',
                                {'tab__element_active': currentTab === COMMERCIAL_OFFER}
                            )}>
                                3. Коммерческое предложение
                            </div>
                        </Columns>
                    </ColumnsWrapper>
                </div>
                <div className="tab-content">
                    {children}
                </div>
            </ContentWrapper>
        </div>
    );
};

Tab.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
    currentTab: PropTypes.string.isRequired,
};

export default Tab;
