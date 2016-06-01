package com.bionic.edu.service;

import com.bionic.edu.entity.Dish;
import com.bionic.edu.entity.DishCategory;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@Ignore
public class DishCategoryServiceImplTest {
    DishCategoryService dishCategoryService;

    @Before
    public void setUp() throws Exception {
        ApplicationContext context = new ClassPathXmlApplicationContext("spring/hibernate-context.xml");
        dishCategoryService = context.getBean(DishCategoryService.class);
    }

    @Test
    public void testFindById() throws Exception {
        DishCategory dishCategory = dishCategoryService.findById(1);
        assertNotNull(dishCategory);
        assertEquals(1, dishCategory.getId());
    }

    @Test
    public void testFindAll() throws Exception {
        List<Dish> dishes = dishCategoryService.findDishes(1);
        assertEquals(3, dishes.size());
    }
}