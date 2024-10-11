import axios from 'axios';

// mouve for Users -------------------------------------------------------------
const API_URL = '/api/users'; 
const API_WORKING_TIMES_URL = '/api/working_times';

export const createUser = async (userData) => {
  try {
    const response = await axios.post(API_URL, userData);
    return response.data; 
  } catch (error) {
    console.error("Error creating user:", error);
    throw error; 
  }
};

export const updateUser = async (id, userData) => {
  try {
    const response = await axios.patch(`${API_URL}/${id}`, userData);
    return response.data; 
  } catch (error) {
    console.error(`Error updating user with ID ${id}:`, error);
    throw error; 
  }
};


export const getUser = async (id) => {
  try {
    const response = await axios.get(`${API_URL}/${id}`);
    return response.data; 
  } catch (error) {
    console.error(`Error fetching user with ID ${id}:`, error);
    throw error; 
  }
};


export const deleteUser = async (id) => {
  try {
    const response = await axios.delete(`${API_URL}/${id}`);
    return response.data; 
  } catch (error) {
    console.error(`Error deleting user with ID ${id}:`, error);
    throw error; 
  }
};

// Mouve Working Time   ---------------------------------------------------

export const createWorkingTime = async (workingTimeData) => {
  try {
    const response = await axios.post(API_WORKING_TIMES_URL, workingTimeData);
    return response.data; 
  } catch (error) {
    console.error("Error creating working time:", error);
    throw error; 
  }
};

export const updateWorkingTime = async (id, workingTimeData) => {
  try {
    const response = await axios.patch(`${API_WORKING_TIMES_URL}/${id}`, workingTimeData);
    return response.data; 
  } catch (error) {
    console.error(`Error updating working time with ID ${id}:`, error);
    throw error; 
  }
};

export const deleteWorkingTime = async (id) => {
  try {
    const response = await axios.delete(`${API_WORKING_TIMES_URL}/${id}`);
    return response.data; 
  } catch (error) {
    console.error(`Error deleting working time with ID ${id}:`, error);
    throw error; 
  }
};

// ClockManager -----------------------------------------

let startDateTime = null;
let clockIn = false; 

// function start working period
export const clock = () => {
  if (!clockIn) {
    startDateTime = new Date(); 
    clockIn = true; 
    console.log(`Clocked in at: ${startDateTime}`);
  } else {
    console.log("Already clocked in.");
  }
};

// function stop working period
export const refresh = () => {
  if (clockIn) {
    const endDateTime = new Date(); 
    const duration = endDateTime - startDateTime; 
    clockIn = false; 
    console.log(`Clocked out at: ${endDateTime}, duration: ${duration}ms`);
    startDateTime = null; 
  } else {
    console.log("Not currently clocked in.");
  }
};

export const isClockedIn = () => {
  return clockIn;
};

export const getStartDateTime = () => {
  return startDateTime;
};

// fake data ----------------------------

export const getAllDataMeteo = () => {
    return {
  "cities": [
    {
      "city": "Paris",
      "temperature": 18,
      "humidity": 72,
      "wind_speed": 15,
      "condition": "Cloudy",
      "forecast": [
        { "day": "Monday", "temperature": 19, "condition": "Partly Cloudy" },
        { "day": "Tuesday", "temperature": 21, "condition": "Sunny" },
        { "day": "Wednesday", "temperature": 17, "condition": "Rainy" }
      ]
    },
    {
      "city": "Lyon",
      "temperature": 22,
      "humidity": 65,
      "wind_speed": 10,
      "condition": "Sunny",
      "forecast": [
        { "day": "Monday", "temperature": 23, "condition": "Sunny" },
        { "day": "Tuesday", "temperature": 24, "condition": "Sunny" },
        { "day": "Wednesday", "temperature": 20, "condition": "Partly Cloudy" }
      ]
    },
    {
      "city": "Marseille",
      "temperature": 24,
      "humidity": 60,
      "wind_speed": 18,
      "condition": "Sunny",
      "forecast": [
        { "day": "Monday", "temperature": 25, "condition": "Sunny" },
        { "day": "Tuesday", "temperature": 26, "condition": "Sunny" },
        { "day": "Wednesday", "temperature": 22, "condition": "Cloudy" }
      ]
    },
    {
      "city": "Bordeaux",
      "temperature": 20,
      "humidity": 68,
      "wind_speed": 12,
      "condition": "Rainy",
      "forecast": [
        { "day": "Monday", "temperature": 21, "condition": "Partly Cloudy" },
        { "day": "Tuesday", "temperature": 22, "condition": "Rainy" },
        { "day": "Wednesday", "temperature": 18, "condition": "Rainy" }
      ]
    },
    {
      "city": "Nice",
      "temperature": 23,
      "humidity": 58,
      "wind_speed": 14,
      "condition": "Partly Cloudy",
      "forecast": [
        { "day": "Monday", "temperature": 24, "condition": "Sunny" },
        { "day": "Tuesday", "temperature": 25, "condition": "Partly Cloudy" },
        { "day": "Wednesday", "temperature": 21, "condition": "Cloudy" }
      ]
    }
  ]
}
}

export const getNameContry = () => {
    return ["Lyon", "Paris","Bordeaux","Marseille"]
}