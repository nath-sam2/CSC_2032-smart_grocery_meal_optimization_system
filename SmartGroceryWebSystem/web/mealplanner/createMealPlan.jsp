<%-- 
    Document   : createMealPlan
    Created on : Jul 13, 2026, 3:52:45 PM
    Author     : perer
--%>
<%@ include file="/nav.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="page-container">

    <h2>Create Healthy Meal Plan</h2>

    <div class="card">
        <h3>Option 1: Auto-Generate Weekly Plan</h3>
        <p>Let the system build a 7-day plan automatically using your dietary restrictions, available inventory, and healthiest recipes.</p>
        <br>
        <a href="MealPlannerController?action=generate" class="btn btn-primary">Generate Meal Plan Automatically</a>
    </div>

    <br>

    <div class="card">
        <h3>Option 2: Create a Custom Plan</h3>

        <form action="MealPlannerController" method="post">

            <input type="hidden" name="action" value="createPlan">

            <p>
                <label>Plan Name</label><br>
                <input type="text" name="planName" value="My Healthy Weekly Plan" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>Start Date</label><br>
                <input type="date" name="startDate" required style="width:100%; padding:8px;">
            </p>

            <p>
                <label>End Date</label><br>
                <input type="date" name="endDate" required style="width:100%; padding:8px;">
            </p>

            <br>
            <button type="submit" class="btn btn-primary">Create Plan</button>
            <a href="MealPlannerController?action=list" class="btn btn-secondary">Cancel</a>

        </form>
    </div>

</div>