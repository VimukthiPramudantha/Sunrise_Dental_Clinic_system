package com.sunrisedental.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
<<<<<<< HEAD
        HttpSession session = request.getSession(false);

        // Security Check: Verify user is logged in
=======

        HttpSession session = request.getSession(false);

        // Security Check: Verify user session exists
>>>>>>> 599ed04e5f73942cf7e5131b795bc5c74c7884e8
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

<<<<<<< HEAD
        // Forward to the dashboard view
=======
        // Forward to JSP view
>>>>>>> 599ed04e5f73942cf7e5131b795bc5c74c7884e8
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
}