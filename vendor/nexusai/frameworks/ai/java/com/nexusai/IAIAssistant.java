/*
 * NANO AIOS - AI Assistant Interface
 * Copyright (C) 2025 The NANO AIOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.nexusai;

/**
 * AI Assistant Interface for NANO AIOS
 * 
 * This interface provides the API for the AI assistant functionality.
 */
interface IAIAssistant {
    /**
     * Process a natural language query
     * @param sessionId The session ID for this interaction
     * @param query The natural language query to process
     * @return The AI's response to the query
     */
    String processQuery(String sessionId, String query);
    
    /**
     * Create a new assistant session
     * @return A unique session ID
     */
    String createSession();
    
    /**
     * End an assistant session
     * @param sessionId The session ID to end
     * @return True if the session was successfully ended
     */
    boolean endSession(String sessionId);
    
    /**
     * Get all active session IDs
     * @return Array of active session IDs
     */
    String[] getActiveSessions();
    
    /**
     * Check if a session ID is valid
     * @param sessionId The session ID to validate
     * @return True if the session is valid
     */
    boolean isValidSession(String sessionId);
    
    /**
     * Get the current status of the AI assistant
     * @return Status information as a string
     */
    String getAssistantStatus();
}