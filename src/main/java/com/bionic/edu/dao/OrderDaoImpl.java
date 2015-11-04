package com.bionic.edu.dao;

import com.bionic.edu.entity.Orders;
import com.bionic.edu.util.ReportInTotal;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.sql.Date;
import java.util.List;

@Repository
public class OrderDaoImpl implements OrderDao {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Orders findById(int id) {
        Orders order;
        order = em.find(Orders.class, id);
        return order;
    }

    @Override
    public List<Orders> findAll() {
        TypedQuery<Orders> query = em.createQuery("SELECT o FROM Orders o", Orders.class);
        return query.getResultList();
    }

    @Override
    public void save(Orders order) {
        if (order.getId() == 0) {
            em.persist(order);
        } else
            em.merge(order);
    }

    @Override
    public void delete(int id) {
        Orders order = em.find(Orders.class, id);
        if (order != null) {
            em.remove(order);
        }
    }


    @Override
    public List<Orders> getDeliveryListByTime() {
        TypedQuery<Orders> query = em.createQuery(
                "SELECT o FROM Orders o WHERE o.orderStatus.id = 2 " +
                        "ORDER BY o.dateTimeTaken DESC", Orders.class);
        return query.getResultList();
    }

    @Override
    public List<Orders> getDeliveryListByStatus() {
        TypedQuery<Orders> query = em.createQuery(
                "SELECT o FROM Orders o WHERE o.orderStatus.id = 2 " +
                        "ORDER BY o.orderStatus.id", Orders.class);
        return query.getResultList();
    }

    @Override
    public List<Orders> getCustomersOrder(int customerId) {
        TypedQuery<Orders> query = em.createQuery(
                "SELECT o FROM Orders o WHERE o.customer.id = :customerId", Orders.class).
                setParameter("customerId", customerId);
        return query.getResultList();
    }

    @Override
    public List<ReportInTotal> getReport(Date startPeriod, Date endPeriod) {
        TypedQuery<ReportInTotal> query = em.createQuery("SELECT new com.bionic.edu.util.ReportInTotal(" +
                "COUNT(od), SUM(od.quantity * d.price), FUNC('DATE', od.order.dateTimeTaken)) " +
                "FROM order_dishes od, Dish d " +
                "WHERE od.dish.id = d.id " +
                "AND FUNC('DATE', od.order.dateTimeTaken) BETWEEN :start AND :finish " +
                "GROUP BY FUNC('DATE', od.order.dateTimeTaken)", ReportInTotal.class);
        query.setParameter("start", startPeriod);
        query.setParameter("finish", endPeriod);
        return query.getResultList();
    }

    @Override
    public List<ReportInTotal> getReport(Date startPeriod, Date endPeriod, String category) {
        TypedQuery<ReportInTotal> query = em.createQuery("SELECT new com.bionic.edu.util.ReportInTotal(" +
                "SUM(od.quantity), SUM(d.price * od.quantity), FUNC('DATE', od.order.dateTimeTaken), " +
                "\"" + category + "\") " +
                "FROM order_dishes od, Dish d where od.order.dateTimeTaken between :start and :finish " +
                "and od.dish.category = \"" + category + "\"" +
                "ORDER BY FUNC('DATE', od.order.dateTimeTaken " +
                "GROUP BY FUNC('DATE', od.order.dateTimeTaken))", ReportInTotal.class);
        query.setParameter("start", startPeriod);
        query.setParameter("finish", endPeriod);
        return query.getResultList();
    }
}
