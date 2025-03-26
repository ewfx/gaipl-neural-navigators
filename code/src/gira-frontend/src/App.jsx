import React, { useState } from 'react';

function App() {
  const [description, setDescription] = useState('');
  const [analysis, setAnalysis] = useState(null);
  const [error, setError] = useState(null); // State for error messages
  const [isLoading, setIsLoading] = useState(false); // State for loading indicator

  const handleSubmit = async (event) => {
    event.preventDefault();
    setIsLoading(true); // Start loading
    setError(null); // Reset previous errors
    try {
      const response = await fetch('http://13.203.207.238:8001/resolve', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ description }),
      });

      if (!response.ok) {
        throw new Error(`Server responded with status: ${response.status}`);
      }

      const data = await response.json();
      setAnalysis(data.analysis);
    } catch (err) {
      setError(`Submission failed: ${err.message}`);
    } finally {
      setIsLoading(false); // End loading
    }
  };

  return (
    <div>
      <h1>GIRA Incident Resolver</h1>
      <form onSubmit={handleSubmit}>
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="Describe the incident..."
        />
        <button type="submit" disabled={isLoading}>
          {isLoading ? 'Submitting...' : 'Submit'}
        </button>
      </form>
      {error && (
        <div style={{ color: 'red' }}>
          <p>{error}</p>
        </div>
      )}
      {analysis && (
        <div>
          <h2>AI Analysis</h2>
          <p>{analysis}</p>
        </div>
      )}
    </div>
  );
}

export default App;

