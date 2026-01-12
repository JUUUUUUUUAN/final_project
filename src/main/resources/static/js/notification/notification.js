/**
 * 
 */



document.addEventListener("DOMContentLoaded", () => {
  loadNotifications();
});

function loadNotifications() {
  fetch("/api/notifications")
    .then(res => res.json())
    .then(data => {
      renderNotifications(data);
      updateNotificationBadge(data);
    })
    .catch(err => console.error("알림 조회 실패", err));
}

function createNotificationItem(n) {
  const li = document.createElement("li");
  li.className = `notify-item ${n.notificationType.toLowerCase()} ${n.notificationReadYn === 'N' ? 'unread' : ''}`;

  li.innerHTML = `
    <div class="notify-signal"></div>

    <div class="notify-icon">
      <i class="bx bx-message-rounded-detail"></i>
    </div>

    <div class="notify-body">
      <div class="notify-header">
        <span class="notify-title">${n.notificationTitle}</span>
        <span class="notify-time">${timeAgo(n.notificationCreatedAt)}</span>
      </div>
      <div class="notify-desc">
        ${n.notificationContent}
      </div>
    </div>
  `;

  li.onclick = () => {
    fetch(`/api/notifications/${n.notificationId}/read`, { method: "PATCH" });
    location.href = n.notificationLink;
  };

  return li;
}

function renderNotifications(notifications) {
  const list = document.getElementById("notificationList");
  list.innerHTML = "";

  notifications.forEach(n => {
    const item = createNotificationItem(n);
    list.appendChild(item);
  });
}


/* 🔔 안 읽은 알림 개수 */
function updateNotificationBadge(notifications) {
  const badge = document.getElementById("notificationBadge");
  const unread = notifications.filter(n => n.notificationReadYn === "N").length;

  if (unread > 0) {
    badge.textContent = unread;
    badge.style.display = "inline-block";
  } else {
    badge.style.display = "none";
  }
}

function timeAgo(dateString) {
  if (!dateString) return "";

  const now = new Date();
  const past = new Date(dateString);
  const diffMs = now - past;

  const seconds = Math.floor(diffMs / 1000);
  const minutes = Math.floor(seconds / 60);
  const hours   = Math.floor(minutes / 60);
  const days    = Math.floor(hours / 24);

  if (seconds < 60) return "방금 전";
  if (minutes < 60) return `${minutes}분 전`;
  if (hours < 24)   return `${hours}시간 전`;
  if (days < 7)     return `${days}일 전`;

  return past.toLocaleDateString();
}

