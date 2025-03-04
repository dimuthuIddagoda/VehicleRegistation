package com.megacitycab.controller;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class LoginControllerTest {
    @Test
    public void testValidateUser() {
        LoginController controller = new LoginController();
        assertTrue(controller.validateUser("admin", "password"));
        assertFalse(controller.validateUser("wrong", "wrong"));
    }
}