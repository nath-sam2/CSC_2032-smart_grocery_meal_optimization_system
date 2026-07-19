/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author perer
 */
import model.NutritionFacts;

public class NutriScoreService {
    
    /**
     * Calculates the official European NutriScore (A, B, C, D, or E).
     * Assumes values are already standardized per 100g/mL.
     * Returns the numeric NutriScore value.
     * Lower values are healthier.
     */
    public static int calculateNutriScoreValue(NutritionFacts nutrition) {

        if (nutrition == null) {
            return Integer.MAX_VALUE;
        }

        double energyKj = nutrition.getCalories() * 4.184;

        int pointsEnergy = getPoints(energyKj,
                new double[]{335,670,1005,1340,1675,2010,2345,2680,3015,3350});

        int pointsSatFat = getPoints(
                nutrition.getSaturatedFat(),
                new double[]{1,2,3,4,5,6,7,8,9,10});

        int pointsSugar = getPoints(
                nutrition.getTotalSugar(),
                new double[]{3.4,6.8,10,13.5,17,20,24,27,31,34,37,41,44,48,51});

        int pointsSodium = getPoints(
                nutrition.getSodium(),
                new double[]{90,180,270,360,450,540,630,720,810,900,
                             990,1080,1170,1260,1350,1440,1530,1620,1710,1800});

        int totalA = pointsEnergy + pointsSatFat + pointsSugar + pointsSodium;

        int pointsFiber = getPoints(
                nutrition.getDietaryFiber(),
                new double[]{3.0,4.1,5.2,6.3,7.4});

        int pointsProtein = getPoints(
                nutrition.getProtein(),
                new double[]{2.4,4.8,7.2,9.6,12.0});

        if (totalA >= 11) {
            return totalA - pointsFiber;
        }

        return totalA - (pointsFiber + pointsProtein);
    }

    public static char calculateNutriScore(NutritionFacts nutrition,
                                           boolean isBeverage) {

        int score = calculateNutriScoreValue(nutrition);

        if (score == Integer.MAX_VALUE) {
            return 'E';
        }

        if (isBeverage) {

            if (score <= 1)
                return 'B';
            if (score <= 5)
                return 'C';
            if (score <= 9)
                return 'D';

            return 'E';
        }

        if (score <= -1)
            return 'A';
        if (score <= 2)
            return 'B';
        if (score <= 10)
            return 'C';
        if (score <= 18)
            return 'D';

        return 'E';
    }

    private static int getPoints(double value, double[] thresholds) {

        int points = 0;

        for (double threshold : thresholds) {

            if (value > threshold) {
                points++;
            } else {
                break;
            }
        }

        return points;
    }
}


