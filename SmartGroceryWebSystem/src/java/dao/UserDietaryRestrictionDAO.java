/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.DietaryRestriction;
import model.UserDietaryRestriction;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class UserDietaryRestrictionDAO {


    // Add restriction to user
    public boolean addUserRestriction(UserDietaryRestriction userRestriction) {


        String checkSQL =
        "SELECT * FROM userdietaryrestrictions WHERE userId=? AND restrictionId=?";


        String insertSQL =
        "INSERT INTO userdietaryrestrictions(userId, restrictionId) VALUES (?, ?)";


        try(Connection conn = DBConnection.getConnection()){


            // Check duplicate
            PreparedStatement checkStmt =
            conn.prepareStatement(checkSQL);


            checkStmt.setInt(1, userRestriction.getUserId());
            checkStmt.setInt(2, userRestriction.getRestrictionId());


            ResultSet rs = checkStmt.executeQuery();


            if(rs.next()){

                return false; // already exists

            }



            PreparedStatement stmt =
            conn.prepareStatement(insertSQL);


            stmt.setInt(1, userRestriction.getUserId());
            stmt.setInt(2, userRestriction.getRestrictionId());


            return stmt.executeUpdate() > 0;



        }catch (Exception e){

            e.printStackTrace();
            return false;

        }

    }




    // Remove restriction from user
    public boolean removeUserRestriction(int userId, int restrictionId) {


        String sql =
        "DELETE FROM userdietaryrestrictions WHERE userId=? AND restrictionId=?";


        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ){


            stmt.setInt(1,userId);
            stmt.setInt(2,restrictionId);


            return stmt.executeUpdate() > 0;



        }catch (Exception e){

            e.printStackTrace();
            return false;

        }

    }





    // Get all restrictions of a specific user
    public List<DietaryRestriction> getRestrictionsByUserId(int userId) {


        List<DietaryRestriction> restrictions =
        new ArrayList<>();


        String sql =
        "SELECT dr.* " +
        "FROM dietaryrestrictions dr " +
        "JOIN userdietaryrestrictions udr " +
        "ON dr.restrictionId = udr.restrictionId " +
        "WHERE udr.userId=?";



        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ){


            stmt.setInt(1,userId);


            ResultSet rs =
            stmt.executeQuery();



            while(rs.next()){


                DietaryRestriction restriction =
                new DietaryRestriction();


                restriction.setRestrictionId(
                rs.getInt("restrictionId"));



                restriction.setRestrictionName(
                rs.getString("restrictionName"));



                restriction.setDescription(
                rs.getString("description"));



                restrictions.add(restriction);


            }



        }catch (Exception e){

            e.printStackTrace();

        }



        return restrictions;

    }







    // Get one user restriction
    public UserDietaryRestriction getUserRestrictionById(
            int userId,
            int restrictionId){



        String sql =
        "SELECT * FROM userdietaryrestrictions " +
        "WHERE userId=? AND restrictionId=?";



        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ){



            stmt.setInt(1,userId);
            stmt.setInt(2,restrictionId);



            ResultSet rs =
            stmt.executeQuery();



            if(rs.next()){


                UserDietaryRestriction udr =
                new UserDietaryRestriction();



                udr.setUserId(
                rs.getInt("userId"));



                udr.setRestrictionId(
                rs.getInt("restrictionId"));



                return udr;


            }




        }catch (Exception e){

            e.printStackTrace();

        }



        return null;

    }








    // Get all user-restriction mappings
    public List<UserDietaryRestriction> getAllUserRestrictions() {



        List<UserDietaryRestriction> list =
        new ArrayList<>();



        String sql =
        "SELECT * FROM userdietaryrestrictions";



        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()
        ){



            while(rs.next()){



                UserDietaryRestriction udr =
                new UserDietaryRestriction();



                udr.setUserId(
                rs.getInt("userId"));



                udr.setRestrictionId(
                rs.getInt("restrictionId"));



                list.add(udr);


            }




        }catch (Exception e){

            e.printStackTrace();

        }



        return list;

    }







    // Get complete restriction details for a user
    public List<UserDietaryRestriction> getUserRestrictionDetails(int userId){


        List<UserDietaryRestriction> list =
        new ArrayList<>();



        String sql =
        "SELECT " +
        "udr.userId, " +
        "udr.restrictionId, " +
        "dr.restrictionName, " +
        "dr.description " +
        "FROM userdietaryrestrictions udr " +
        "JOIN dietaryrestrictions dr " +
        "ON udr.restrictionId = dr.restrictionId " +
        "WHERE udr.userId=?";



        try(
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ){



            stmt.setInt(1,userId);



            ResultSet rs =
            stmt.executeQuery();




            while(rs.next()){



                DietaryRestriction restriction =
                new DietaryRestriction();



                restriction.setRestrictionId(
                rs.getInt("restrictionId"));



                restriction.setRestrictionName(
                rs.getString("restrictionName"));



                restriction.setDescription(
                rs.getString("description"));





                UserDietaryRestriction udr =
                new UserDietaryRestriction();



                udr.setUserId(
                rs.getInt("userId"));



                udr.setRestrictionId(
                rs.getInt("restrictionId"));



                udr.setDietaryRestrictions(restriction);



                list.add(udr);


            }



        }catch (Exception e){

            e.printStackTrace();

        }



        return list;

    }


}