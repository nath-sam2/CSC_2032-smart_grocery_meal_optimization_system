/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author perer
 */
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MealPlanner {
    private int mealPlanId;
    private int userId;
    private String planName;
    private LocalDate startDate;
    private LocalDate endDate;
    private List<MealPlanDetail> mealPlanDetails;

    public MealPlanner() {
        mealPlanDetails = new ArrayList<>();
    }

    public MealPlanner(int mealPlanId, int userId, String planName,
                       LocalDate startDate, LocalDate endDate) {

        this.mealPlanId = mealPlanId;
        this.userId = userId;
        this.planName = planName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.mealPlanDetails = new ArrayList<>();
    }

    public void addRecipe(MealPlanDetail detail) {
        mealPlanDetails.add(detail);
    }

    public void removeRecipe(MealPlanDetail detail) {
        mealPlanDetails.remove(detail);
    }

    public List<MealPlanDetail> getMealPlanByDate(LocalDate date) {

        List<MealPlanDetail> meals = new ArrayList<>();

        for (MealPlanDetail detail : mealPlanDetails) {
            if (detail.getMealDate().equals(date)) {
                meals.add(detail);
            }
        }

        return meals;
    }

    public void generateWeeklyPlan() {
        System.out.println("Weekly meal plan generated.");
    }

    public int getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(int mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public List<MealPlanDetail> getMealPlanDetails() {
        return mealPlanDetails;
    }

    public void setMealPlanDetails(List<MealPlanDetail> mealPlanDetails) {
        this.mealPlanDetails = mealPlanDetails;
    }

    @Override
    public String toString() {
        return "MealPlanner{" + "mealPlanId=" + mealPlanId + ", userId=" + userId + ", planName='" + planName + '\'' +
                ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }
}
