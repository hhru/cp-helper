package ru.hh.cphelper;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.After;
import org.springframework.test.context.ContextConfiguration;
import ru.hh.nab.hibernate.transaction.TransactionalScope;
import ru.hh.nab.testbase.NabTestBase;

import javax.inject.Inject;

@ContextConfiguration(classes = CpHelperTestConfig.class)
public abstract class CpHelperTestBase extends NabTestBase {

    @Inject
    protected TransactionalScope transactionalScope;

    @Inject
    private SessionFactory sessionFactory;

    protected Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    @After
    public void tearDown() {
        transactionalScope.write(() -> {
            currentSession().createQuery("DELETE FROM Competitor").executeUpdate();
        });
    }
}
