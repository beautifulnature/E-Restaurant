package com.bionic.edu.service;

import com.bionic.edu.dao.DishDao;
import com.bionic.edu.entity.Dish;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
public class DishServiceImpl implements DishService {

    @Inject
    private DishDao dishDao;

    @Override
    public Dish findById(int id) {
        return dishDao.findById(id);
    }

    @Override
    public List<Dish> findAll() {
        return dishDao.findAll();
    }

    @Transactional
    @Override
    public void add(Dish dish) {
        dishDao.add(dish);
    }

    @Override
    public void update(Dish dish) {
        dishDao.update(dish);
    }

    @Transactional
    @Override
    public void delete(int id) {
        dishDao.delete(id);
    }
}
