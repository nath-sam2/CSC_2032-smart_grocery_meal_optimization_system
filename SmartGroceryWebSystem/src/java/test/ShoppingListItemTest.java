/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */

import dao.ShoppingListItemDAO;
import model.ShoppingListItem;

import java.util.List;

public class ShoppingListItemTest {
     public static void main(String[] args) {

        ShoppingListItemDAO dao = new ShoppingListItemDAO();

        if (dao.deleteShoppingListItem(1)) {
            System.out.println("Shopping List Item deleted successfully!");
        } else {
            System.out.println("Delete failed!");
        }
    }
}
