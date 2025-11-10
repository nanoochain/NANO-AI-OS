/*
 * NANO AIOS - AI Assistant Test App
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

package com.nexusai.assistanttest;

import android.app.Activity;
import android.os.Bundle;
import android.os.ServiceManager;
import android.os.RemoteException;
import android.util.Log;
import android.widget.TextView;

import com.nexusai.IAIAssistant;

/**
 * Test application for the AI Assistant service
 */
public class MainActivity extends Activity {
    private static final String TAG = "AIAssistantTest";
    
    private IAIAssistant mAIAssistant;
    private TextView mStatusText;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        mStatusText = new TextView(this);
        setContentView(mStatusText);
        
        // Get the AI Assistant service
        try {
            mAIAssistant = IAIAssistant.Stub.asInterface(
                ServiceManager.getService("ai_assistant"));
            
            if (mAIAssistant != null) {
                testAIAssistant();
            } else {
                mStatusText.setText("Failed to get AI Assistant service");
                Log.e(TAG, "Failed to get AI Assistant service");
            }
        } catch (Exception e) {
            Log.e(TAG, "Error getting AI Assistant service", e);
            mStatusText.setText("Error: " + e.getMessage());
        }
    }
    
    private void testAIAssistant() {
        try {
            Log.i(TAG, "Testing AI Assistant...");
            
            // Get assistant status
            String status = mAIAssistant.getAssistantStatus();
            Log.i(TAG, "Assistant Status:\n" + status);
            
            // Create a session
            String sessionId = mAIAssistant.createSession();
            Log.i(TAG, "Created session: " + sessionId);
            
            // Process a test query
            String response = mAIAssistant.processQuery(sessionId, "Hello, how are you?");
            Log.i(TAG, "Query response: " + response);
            
            // End the session
            boolean ended = mAIAssistant.endSession(sessionId);
            Log.i(TAG, "Session ended: " + ended);
            
            // Display results
            StringBuilder results = new StringBuilder();
            results.append("AI Assistant Test Results:\n\n");
            results.append("Status:\n").append(status).append("\n\n");
            results.append("Session ID: ").append(sessionId).append("\n");
            results.append("Response: ").append(response).append("\n");
            results.append("Session ended: ").append(ended);
            
            mStatusText.setText(results.toString());
        } catch (RemoteException e) {
            Log.e(TAG, "Error testing AI Assistant", e);
            mStatusText.setText("Error: " + e.getMessage());
        }
    }
}