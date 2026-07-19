/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
public class DietaryRestriction {
    private int restrictionId;
    private String restrictionName;
    private String description;
    
    public DietaryRestriction(){}

    public DietaryRestriction(int restrictionId, String restrictionName, String description) {
        this.restrictionId = restrictionId;
        this.restrictionName = restrictionName;
        this.description = description;
    }

    public int getRestrictionId() {
        return restrictionId;
    }

    public void setRestrictionId(int restrictionId) {
        this.restrictionId = restrictionId;
    }

    public String getRestrictionName() {
        return restrictionName;
    }

    public void setRestrictionName(String restrictionName) {
        this.restrictionName = restrictionName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "dietaryRestriction{" + "restrictionId=" + restrictionId + ", restrictionName=" + restrictionName + ", description=" + description + '}';
    }
    
}
