#!/usr/bin/env bash
# Unattended repo-review-job runner, invoked by the systemd user timer
# repo-review-job.timer. Runs from ether-pro's directory (job store lives
# in ether-pro/.ether/jobs.db) with read access added for target repos.
set -euo pipefail

cd "$HOME/wrkspc/ether-pro"

claude -p "Use the repo-review-job skill now. Running unattended via cron/systemd, no human present to approve confirm-tier actions: for any job/action that 'ether job should-confirm' reports as needing confirmation, skip it (do not act), record nothing as a run for that step, and note it clearly in the final report so the user can review and approve manually next session. Never treat unattended = autonomous." \
  --add-dir "$HOME/wrkspc/dar-money-mind" \
  --allowedTools "Bash,Read,Grep,Glob" \
  >> "$HOME/.local/share/repo-review-cron.log" 2>&1

echo "--- run at $(date -Is) ---" >> "$HOME/.local/share/repo-review-cron.log"
