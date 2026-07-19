/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class UserDietaryRestriction {
    private int userId;
    private int restrictionId;
    private DietaryRestriction dietaryRestriction;
    
    public UserDietaryRestriction(){}

    public UserDietaryRestriction(int userId, int restrictionId, DietaryRestriction dietaryRestrictions) {
        this.userId = userId;
        this.restrictionId = restrictionId;
        this.dietaryRestriction = dietaryRestrictions;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRestrictionId() {
        return restrictionId;
    }

    public void setRestrictionId(int restrictionId) {
        this.restrictionId = restrictionId;
    }

    public DietaryRestriction getDietaryRestrictions() {
        return dietaryRestriction;
    }

    public void setDietaryRestrictions(DietaryRestriction dietaryRestrictions) {
        this.dietaryRestriction = dietaryRestrictions;
    }

    @Override
    public String toString() {
        return "UserDietaryRestriction{" + "userId=" + userId + ", restrictionId=" + restrictionId + ", DietaryRestrictions=" + dietaryRestriction + '}';
    }
    
    
}
