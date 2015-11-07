package com.bionic.edu.service;

import com.bionic.edu.dao.OrderDao;
import com.bionic.edu.dao.OrderDishesDao;
import com.bionic.edu.dao.OrderStatusDao;
import com.bionic.edu.entity.Orders;
import com.bionic.edu.util.ReportCategory;
import com.bionic.edu.util.ReportTotal;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.sql.Date;
import java.util.List;

@Named
public class OrderServiceImpl implements OrderService {

    @Inject
    private OrderDao orderDao;
    @Inject
    private OrderStatusDao orderStatusDao;
    @Inject
    private OrderDishesDao orderDishesDao;

    @Override
    public Orders findById(int id) {
        return orderDao.findById(id);
    }

    @Override
    public List<Orders> findAll() {
        return orderDao.findAll();
    }

    @Transactional
    @Override
    public void save(Orders order) {
        orderDao.save(order);
    }

    @Transactional
    @Override
    public void delete(int id) {
        orderDao.delete(id);
    }


    @Transactional
    @Override
    public void setOrderStatus(int orderId, int statusId) {
        Orders order = orderDao.findById(orderId);
        order.setOrderStatus(orderStatusDao.findById(statusId));
        orderDao.save(order);
    }

    @Override
    public List<Orders> getDeliveryListByTime() {
        return orderDao.getDeliveryListByTime();
    }

    @Override
    public List<Orders> getDeliveryListByStatus() {
        return orderDao.getDeliveryListByStatus();
    }

    @Override
    public List<Orders> getCustomersOrder(int customerId) {
        return orderDao.getCustomersOrder(customerId);
    }


    @Override
    public List<ReportTotal> getReportTotal(Date startPeriod, Date endPeriod) {
        return orderDao.getReportTotal(startPeriod, endPeriod);
    }

    @Override
    public List<ReportCategory> getReportCategory(Date startPeriod, Date endPeriod) {
        return orderDao.getReportCategory(startPeriod, endPeriod);
    }
}
