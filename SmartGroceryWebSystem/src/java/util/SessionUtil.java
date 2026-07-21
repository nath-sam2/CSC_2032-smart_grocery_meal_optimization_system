/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.http.HttpSession;
import model.User;

/**
 * Central place to read the logged-in user's id out of the session.
 *
 * LoginServlet (Member 1) stores the whole User object under the
 * session key "user" - it does NOT store a separate "userId" key.
 * Falls back to a fixed demo user id when nobody is logged in
 * (e.g. hitting a page directly while testing).
 */
public class SessionUtil {

    private static final int DEFAULT_USER_ID = 6;

    public static int getLoggedInUserId(HttpSession session) {

        if (session != null) {

            Object userObj = session.getAttribute("user");

            if (userObj instanceof User) {
                return ((User) userObj).getUserId();
            }
        }

        return DEFAULT_USER_ID;
    }
}