import {NotificationManager} from 'react-notifications';

export default function createNotification(type, message, title) {
    switch (type) {
        case 'info':
            NotificationManager.info(message, title, 3000);
            break;
        case 'success':
            NotificationManager.success(message, title, 2000);
            break;
        case 'warning':
            NotificationManager.warning(message, title, 3000);
            break;
        case 'error':
            NotificationManager.error(message, title, 3000);
        break;
    }
}
